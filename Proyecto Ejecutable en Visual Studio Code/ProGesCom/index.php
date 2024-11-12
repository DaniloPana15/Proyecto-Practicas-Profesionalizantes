<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seguimiento de Proyectos</title>
    <link rel="stylesheet" href="styles.css">
    <script>
    function mostrarDetalle(nombre, contrato, propuesta, monto, estado) {
        const modal = document.getElementById('detalle-proyecto');
        document.getElementById('detalle-contenido').innerHTML = `
            <h3>Detalles del Proyecto</h3>
            <p><strong>Nombre:</strong> ${nombre}</p>
            <p><strong>Contrato:</strong> ${contrato}</p>
            <p><strong>Propuesta:</strong> ${propuesta}</p>
            <p><strong>Monto:</strong> ${monto}</p>
            <p><strong>Estado:</strong> ${estado}</p>
            <button class="close-button" onclick="cerrarDetalle()">Cerrar</button>
            <button onclick="exportarPDF('${nombre}', '${contrato}', '${propuesta}', '${monto}', '${estado}')">Descargar PDF</button>
        `;
        modal.style.display = 'flex';
    }

    function cerrarDetalle() {
        document.getElementById('detalle-proyecto').style.display = 'none';
    }

    function exportarPDF(nombre, contrato, propuesta, monto, estado) {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        doc.text(`Detalles del Proyecto: ${nombre}`, 10, 10);
        doc.text(`Contrato: ${contrato}`, 10, 20);
        doc.text(`Propuesta: ${propuesta}`, 10, 30);
        doc.text(`Monto: ${monto}`, 10, 40);
        doc.text(`Estado: ${estado}`, 10, 50);

        // Guarda el PDF
        doc.save(`${nombre}_detalles.pdf`);
    }
</script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</head>
<body>
<header>
    <h1>Seguimiento de Proyectos</h1>
</header>

<div class="container">
    <?php
    session_start();
    include 'db.php';

    if (!isset($_SESSION['user_id'])) {
        header('Location: login.php');
        exit();
    }

    if ($_SESSION['role'] == 'admin') {
        echo "<h2>Crear Proyecto</h2>";
        echo "<form action='crear_proyecto.php' method='POST'>
                <input type='text' name='nombre' placeholder='Nombre del Proyecto' required>
                <input type='text' name='contrato' placeholder='Contrato' required>
                <textarea name='propuesta' placeholder='Propuesta'></textarea>
                <input type='number' name='monto' placeholder='Monto' required>
                <button type='submit'>Crear Proyecto</button>
              </form>";

        echo "<h2>Asignar Proyecto a Usuario</h2>";
        echo "<form action='asignar_proyecto.php' method='POST'>
                <label for='proyecto_id'>Proyecto:</label>
                <select name='proyecto_id' required>";

        $proyectos = $conn->query("SELECT id, nombre FROM proyectos");
        while ($proyecto = $proyectos->fetch_assoc()) {
            echo "<option value='{$proyecto['id']}'>{$proyecto['nombre']}</option>";
        }
        echo "</select>";

        echo "<label for='usuario_id'>Usuario:</label>
              <select name='usuario_id' required>";

        $usuarios = $conn->query("SELECT id, username FROM usuarios WHERE role = 'user'");
        while ($usuario = $usuarios->fetch_assoc()) {
            echo "<option value='{$usuario['id']}'>{$usuario['username']}</option>";
        }
        echo "</select>";
        
        echo "<button type='submit'>Asignar Proyecto</button>
              </form>";
    }
    ?>
</div>

<div class="container2">
    <h2>Proyectos Asignados</h2>
    <table>
        <thead>
            <tr>
                <th>Nombre del Proyecto</th>
                <th>Contrato</th>
                <th>Propuesta</th>
                <th>Monto</th>
                <th>Estado</th>
                <th>Asignado a</th>
            </tr>
        </thead>
        <tbody>
            <?php
            if ($_SESSION['role'] == 'admin') {
                $query = "SELECT p.nombre, p.contrato, p.propuesta, p.monto, p.estado, u.username AS asignado_a 
                          FROM proyectos p
                          JOIN proyectos_asignados pa ON p.id = pa.proyecto_id
                          JOIN usuarios u ON pa.usuario_id = u.id";
                $stmt = $conn->prepare($query);
            } else {
                $user_id = $_SESSION['user_id'];
                $query = "SELECT p.nombre, p.contrato, p.propuesta, p.monto, p.estado
                          FROM proyectos p
                          JOIN proyectos_asignados pa ON p.id = pa.proyecto_id
                          WHERE pa.usuario_id = ?";
                $stmt = $conn->prepare($query);
                $stmt->bind_param("i", $user_id);
            }

            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                while ($row = $result->fetch_assoc()) {
                    echo "<tr>
                            <td>{$row['nombre']}</td>
                            <td>{$row['contrato']}</td>
                            <td>{$row['propuesta']}</td>
                            <td>{$row['monto']}</td>
                            <td>{$row['estado']}</td>";
                    if ($_SESSION['role'] == 'admin') {
                        echo "<td>{$row['asignado_a']}</td>";
                    }
                    echo "</tr>";
                }
            } else {
                echo "<tr><td colspan='6'>No hay proyectos asignados</td></tr>";
            }

            $stmt->close();
            ?>
        </tbody>
    </table>
</div>
<!-- ;) -->
<?php if ($_SESSION['role'] == 'admin'): ?>
    <div class="container3">
        <h2>Proyectos existentes</h2>
        <div>
        <?php
        $query = "SELECT p.nombre, p.contrato, p.propuesta, p.monto, p.estado FROM proyectos p";
        $stmt = $conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                echo "<div>
                    <h3>{$row['nombre']}</h3>
                    <button onclick=\"mostrarDetalle(
                        '{$row['nombre']}', 
                        '{$row['contrato']}', 
                        '{$row['propuesta']}', 
                        '{$row['monto']}', 
                        '{$row['estado']}'
                    )\">Mostrar Detalles</button>
                </div>";
            }
        }
        $stmt->close();
        ?>
    </div>
    </div>
<?php endif; ?>

<div id="detalle-proyecto" class="modal">
    <div class="modal-content" id="detalle-contenido">
        <button class="close-button" onclick="cerrarDetalle()">Cerrar</button>
        <!-- Aquí se mostrarán los detalles del proyecto seleccionado -->
    </div>
</div>



</body>
</html>

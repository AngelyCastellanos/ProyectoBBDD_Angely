# 📊 Proyecto Diseño de Base de Datos para Cliente

## Descripción
Este proyecto consiste en el diseño y desarrollo de una base de datos para gestionar la información de un centro médico, facilitando el manejo y el orden de los datos relacionados con pacientes, médicos, citas, servicios y otros aspectos clave de la atención médica. El objetivo es construir una base de datos eficiente y funcional que responda a las necesidades operativas del centro.


---

## 📑 Tabla de Contenidos

- [Requisitos](#-requisitos)  
- [Fases del Proyecto](#-fases-del-proyecto)  
  - [1. Recolección de Requisitos](#1-recolección-de-requisitos)  
  - [2. Diseño Conceptual](#2-diseño-conceptual)  
  - [3. Diseño Lógico](#3-diseño-lógico)  
  - [4. Diseño Físico](#4-diseño-físico)  
  - [5. Implementación en MySQL](#5-implementación-en-mysql)  
  - [6. Pruebas y Validación](#6-pruebas-y-validación)  
- [Estructura del Repositorio](#-estructura-del-repositorio)  
- [Instalación y Uso](#-instalación-y-uso)  
- [Contribuciones](#-contribuciones)  
- [Licencia](#-licencia)

---

## 📝 Requisitos

- **MySQL 8.0+**  
- **MySQL Workbench** (opcional, para diagramas y administración)  
- **Git**  
- **Sistema operativo**: Windows, Linux o macOS  

---

## 🔄 Fases del Proyecto

### 1. Recolección de Requisitos
- Entrevistas con el cliente  
- Identificación de entidades y procesos clave  
- Definición de reglas de negocio y restricciones  

**Entregables**: Documento de requisitos funcionales y no funcionales (`Memoria Proyecto BBDD`).

### 2. Diseño Conceptual
- Creación de Diagrama Entidad–Relación (ER)  
- Definición de entidades, atributos y relaciones  
- Validación con el cliente

**Entregables**: Diagrama ER en PDF/PNG (`docs/ER_diagram.png`).

### 3. Diseño Lógico
- Transformación del modelo ER a un modelo relacional  
- Definición de tablas, claves primarias y foráneas  
- Normalización (hasta 3FN o BCNF según corresponda)

**Entregables**: Script de creación de tablas lógico (`sql/01_logical_schema.sql`).

### 4. Diseño Físico
- Ajustes de tipos de datos según MySQL  
- Definición de índices, vistas y procedimientos almacenados  
- Plan de particionamiento (si aplica)

**Entregables**: Script de esquema físico y optimizaciones (`sql/02_physical_schema.sql`).

### 5. Implementación en MySQL
- Creación de la base de datos  
- Ejecución de scripts DDL y DML de muestra  
- Poblado inicial de datos de prueba

**Entregables**:  
- `sql/03_create_database.sql`  
- `sql/04_seed_data.sql`

### 6. Pruebas y Validación
- Pruebas de integridad referencial  
- Pruebas de consultas de negocio (SELECT, JOIN, agregaciones)  
- Pruebas de rendimiento y optimización de consultas  
- Documentación de resultados

**Entregables**:  
- Reporte de pruebas (`docs/tests_report.md`)  
- Script de casos de prueba (`sql/05_test_queries.sql`)

---

## 🗂️ Estructura del Repositorio

```
ProyectoBBDD_Angely/
│
├── docs/
│   ├── requisitos.md              # Documento de requisitos
│   ├── ER_diagram.png             # Diagrama entidad-relación
│   └── tests_report.md            # Resultados de pruebas y verificación
│
├── sql/
│   ├── 01_logical_schema.sql      # Definición de esquema lógico
│   ├── 02_physical_schema.sql     # Optimización y ajustes físicos
│   ├── 03_create_database.sql     # Script de creación de base de datos
│   ├── 04_seed_data.sql           # Inserción de datos iniciales
│   └── 05_test_queries.sql        # Casos de prueba SQL
│
├── README.md                      # Este archivo
└── .gitignore
```

---

## ⚙️ Instalación y Uso

1. Clonar el repositorio:  
   ```bash
   git clone https://github.com/AngelyCastellanos/ProyectoBBDD_Angely.git
   ```

2. Abrir MySQL Workbench o tu editor SQL preferido.

3. Ejecutar los scripts en orden:
   - `03_create_database.sql`
   - `04_seed_data.sql`
   - `05_test_queries.sql` (opcional, para pruebas)

---

## 🤝 Contribuciones

Este proyecto fue desarrollado como trabajo individual para el módulo de Bases de Datos. No se aceptan contribuciones externas en esta etapa.

---

## 📄 Licencia

Este proyecto es de uso académico. No está destinado para distribución comercial. Para fines educativos únicamente.

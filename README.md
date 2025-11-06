# proba-release-please

Colección de módulos de Terraform para AWS.

## Módulos Disponibles

Este repositorio contiene 4 módulos de Terraform para la gestión de recursos en AWS:

### 1. aws-rds - Base de Datos RDS
Módulo para crear y gestionar instancias de Amazon RDS con soporte para múltiples motores de base de datos (PostgreSQL, MySQL, MariaDB).

**Características principales:**
- Instancias RDS con encriptación
- Grupo de subnets configurables
- Backups automáticos
- Soporte Multi-AZ
- Integración con CloudWatch Logs

[Ver documentación completa →](./aws-rds/README.md)

### 2. aws-rabbitmq - Amazon MQ (RabbitMQ)
Módulo para crear brokers de RabbitMQ usando Amazon MQ.

**Características principales:**
- Instancia única o clúster Multi-AZ
- Gestión de usuarios múltiples
- Integración con CloudWatch
- Ventanas de mantenimiento configurables
- Configuración de seguridad VPC

[Ver documentación completa →](./aws-rabbitmq/README.md)

### 3. aws-s3 - Bucket S3
Módulo para crear y gestionar buckets de S3 con mejores prácticas de seguridad.

**Características principales:**
- Encriptación del servidor (SSE-S3 o SSE-KMS)
- Versionado de objetos
- Bloqueo de acceso público
- Reglas de ciclo de vida
- Configuración CORS
- Logging de accesos

[Ver documentación completa →](./aws-s3/README.md)

### 4. aws-cdn - CloudFront CDN
Módulo para crear distribuciones de CloudFront para entrega de contenido.

**Características principales:**
- Soporte para orígenes S3 y personalizados
- Origin Access Identity (OAI)
- Certificados SSL personalizados vía ACM
- Comportamientos de caché múltiples
- Asociaciones Lambda@Edge
- Restricciones geográficas
- Integración con AWS WAF

[Ver documentación completa →](./aws-cdn/README.md)

## Uso General

Para usar cualquiera de estos módulos en tu configuración de Terraform:

```hcl
module "nombre_modulo" {
  source = "./aws-<nombre-modulo>"
  
  # Variables específicas del módulo
  # Ver la documentación de cada módulo para detalles
}
```

## Requisitos

- Terraform >= 1.0
- AWS Provider >= 4.0
- Credenciales de AWS configuradas

## Estructura del Repositorio

```
.
├── aws-rds/         # Módulo de RDS
├── aws-rabbitmq/    # Módulo de RabbitMQ (Amazon MQ)
├── aws-s3/          # Módulo de S3
├── aws-cdn/         # Módulo de CloudFront
└── README.md        # Este archivo
```

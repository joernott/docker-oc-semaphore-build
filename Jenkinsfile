pipeline {
  agent {
    label 'docker'
  }

  stages {
    stage('Build') {
      steps {
        echo "building image ${env.REGISTRY}/oc/base:${env.IMAGE_TAG}..."
        sh "docker build -t ${env.REGISTRY}/oc/base:${env.IMAGE_TAG} ."
      }
    }
    stage('Push') {
      steps {
        echo "pushing new image ${env.REGISTRY}/oc/base:${env.IMAGE_TAG}..."
        sh "docker push ${env.REGISTRY}/oc/base:${env.IMAGE_TAG}"
      }
    }
  }
}

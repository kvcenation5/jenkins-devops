pipeline {
	agent any
	// agent {
	// 	docker {
	// 		image 'gradle:jre8'
	// 	}
	//}
	environment {
		dockerHome = tool 'myDocker'
		mavenHome = tool 'myMaven'
		PATH = "$dockerHome/bin:$mavenHome/bin:$PATH"
	}
	stages{
		stage('Checkout') {
			steps {
				sh 'mvn --version'
				sh 'docker version'
				echo "Build"
				echo "$PATH"
				echo "BUILD NUMBER - $env.BUILD_NUMBER"
				echo "BUILD_ID - $env.BUILD_ID"
				echo "JOB NAME - $env.JOB_NAME"
				echo "$env.BUILD_TAG"
				echo "$env.BUILD_URL"
				echo "Integration test"
			}
		}

		stage('Compile') {
			steps {
				sh "mvn clean compile"
			}
		}

		stage('Test') {
			steps {
				sh "mvn test"
			}
		}

		stage('Integration Test') {
			steps {
				sh "mvn failsafe:integration-test failsafe:verify"
			} 
		}

		stage('Package') {
			steps {
				sh "mvn package -DskipTests"
			}
		}

		stage("Build Docker Image") {
			steps{
				//docker build -t in28min/currency-exchange-devops:$env.BUILD_TAG
				script {
					dockerImage = docker.build("docker1096/currency-exchange-devops:$env.BUILD_TAG")
				}
			}
		}
		stage('Push Docker Image') {
			steps{
				script {
					docker.withRegistry('','docker') {
						dockerImage.push();
						dockerImage.push('latest');
					}

				}
			}
		}
	}

post {
	always {
		echo 'I am awesome'
	}
	success {
		echo 'I run mostly to succeed'
	}
	failure {
		echo 'I run when you fail'
	}
	cleanup {
		echo 'This is a cleanup process'
	}
	changed {
		echo 'Its changed'
	}
}
}

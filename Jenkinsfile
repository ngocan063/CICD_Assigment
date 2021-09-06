	pipeline {
		agent any
		environment {
			AWS_REGION  = 'us-east-1'
			ECR_CODE    = '132902260222'
			CONTAINER_NAME = 'an_assignment'
			}
		stages {
			stage('GitCheckout') {
				steps {
					git 'https://github.com/ngocan063/CICD_Assigment.git'
					
			}
		}
			 stage('Docker Build') {
				  steps {
						sh(label: 'ECR login and docker push', script:
						'''
						#!/bin/bash
						echo "Authenticate with ECR"
						set +x 
						echo "Building New ECR Image"
						eval $(aws ecr get-login --region "$AWS_REGION" --no-include-email)
						set -xe
						docker build  -t "$ECR_CODE".dkr.ecr.us-east-1.amazonaws.com/antruong-assignment-ecr:latest .
						docker push "$ECR_CODE".dkr.ecr.us-east-1.amazonaws.com/antruong-assignment-ecr:latest
						docker tag "$ECR_CODE".dkr.ecr.us-east-1.amazonaws.com/antruong-assignment-ecr:latest "$ECR_CODE".dkr.ecr.us-east-1.amazonaws.com/antruong-assignment-ecr:testapp
						docker push "$ECR_CODE".dkr.ecr.us-east-1.amazonaws.com/antruong-assignment-ecr
			 '''.stripIndent())
		  }
		}
			 stage ('Docker deploy') {
				 steps {
					 script {
						sh '''#!/bin/bash
						ssh -v -i /home/ubuntu/jenkin/.ssh/id_rsa root@10.0.2.99 
						ssh -v -i /home/ubuntu/jenkin/.ssh/id_rsa root@10.0.2.99 >> ENDSSH
						set +x
						echo "Pull ECR Image"
						eval $(aws ecr get-login --region "$AWS_REGION" --no-include-email)
						set -xe
						docker pull "$ECR_CODE".dkr.ecr.us-east-1.amazonaws.com/antruong-assignment-ecr:latest
						if [ ! "$(docker ps -q -f name="$CONTAINER_NAME" ]; then
						docker stop "$CONTAINER_NAME"
						fi
						# Run your container
						docker run -d --name "$CONTAINER_NAME" "$ECR_CODE".dkr.ecr.us-east-1.amazonaws.com/antruong-assignment-ecr
						fi
ENDSSH
'''
						 }
						 
			 }
		
	}
	}
	}
	
	

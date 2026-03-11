node {

    // Checkout source code dari repository
    stage("Checkout") {
        checkout scm
    }

    // Build environment (dev)
    stage("Build") {
        docker.image('composer:2').inside('-u root') {
            sh '''
            composer install \
            --no-interaction \
            --prefer-dist \
            --optimize-autoloader
            '''
        }
    }

    // Testing stage
    stage("Testing") {
        docker.image('ubuntu').inside('-u root') {
            sh 'echo "Ini adalah test"'
        }
    }

    // Deploy environment production
    stage('Deploy Prod') {
    steps {
        sshagent(['ssh-prod']) {
            sh '''
            mkdir -p ~/.ssh
            ssh-keyscan -H 172.29.18.240 >> ~/.ssh/known_hosts

            rsync -rav --delete ./ napoleon@172.29.18.240:/home/napoleon/prod.kelasdevops.xyz/ \
            --exclude=.env \
            --exclude=storage \
            --exclude=.git
            '''
        }
    }
}

}

#!/usr/bin/env groovy

/**
        * from https://github.com/aquinok/pipeLiner
        * by guyern@gmail.com
*/

import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL

try {
    pipeline {
        agent any

        stages {
            stage("Cloning Pipeliner") {
                steps {
                    echo "Cloning Pipeliner"
                    // git url: 'git@github.com:aquinok/pipeLiner.git'
                    sh './pipeLiner.sh'
                }
            }
        }
    }
} catch (e) {
    // currentBuild.result = "FAILED"
    throw e
} finally {
    // notifyBuild(currentBuild.result)
    echo "\u2713 Done"
}


// Function for sending build status to slack
def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"
  def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)
}

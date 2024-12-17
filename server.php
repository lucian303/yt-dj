#! /usr/bin/php

<?php
header("Content-Type: application/json"); // Set content type to JSON for the response
header("Access-Control-Allow-Origin: *"); // CORS
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    // Respond to the preflight request
    http_response_code(200); // No Content
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the raw POST data and decode it as JSON
    $input = file_get_contents("php://input");
    $data = json_decode($input, true);

    // Check if JSON decoding was successful
    if (json_last_error() !== JSON_ERROR_NONE) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "Invalid JSON payload."]);
        exit;
    }

    // Check if the 'url' field is provided in the JSON data
    if (isset($data['url'])) {
        $url = escapeshellarg($data['url']); // Escape the URL for safe CLI usage

        // Define your CLI command
        $command = "./song.sh music/new " . $url;

        // Execute the command
        $output = shell_exec($command);

        // Return a response
        if ($output === null) {
            http_response_code(500);
            echo json_encode(["status" => "error", "message" => "Command execution failed."]);
        } else {
            echo json_encode(["status" => "success", "output" => $output]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "No URL provided."]);
    }
} else {
    http_response_code(405);
    echo json_encode(["status" => "error", "message" => "Method not allowed."]);
}

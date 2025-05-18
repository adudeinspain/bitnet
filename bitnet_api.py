from fastapi import FastAPI, Request
from pydantic import BaseModel
import subprocess

app = FastAPI()

class CompletionRequest(BaseModel):
    prompt: str
    max_tokens: int = 128

@app.post("/v1/completions")
async def complete(req: CompletionRequest):
    # Replace with a subprocess call to run_inference.py with input
    result = subprocess.run(
        ["python3", "run_inference.py", "--prompt", req.prompt],
        capture_output=True, text=True
    )
    return {
        "id": "bitnet-completion",
        "object": "text_completion",
        "choices": [{"text": result.stdout.strip()}]
    }

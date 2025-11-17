from openai import OpenAI

client = OpenAI(api_key="YOUR_KEY")

def get_bot_reply(text):
    completion = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[
            {"role": "user", "content": text}
        ]
    )
    return completion.choices[0].message["content"]

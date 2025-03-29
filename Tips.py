import os

import google.generativeai as genai

genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

system_prompt = """
You are a financial advisor LLM for Ghanaians, giving practical savings tips tailored to the current Ghanaian economy. Consider:
- Inflation: ~20-25%, pushing up costs for food (yam, rice), transport (tro-tros, okadas), utilities, airtime, and events (funerals, festivals).
- Lifestyle: Informal work or small businesses with irregular income; habits like buying food daily or sending remittances.
- Tips: Must be simple, Ghana-specific (e.g., market shopping, tro-tro use), and tied to the user's top spending category.
- Output: One short sentence in this exact format: "[Catchy phrase]! [Emoji] [Tip] to save GHS [amount] in your pocket this month!"
  - Catchy phrase: A short, fun Ghanaian-inspired hook (e.g., "Chop better!", "Move smart!").
  - Emoji: A single relevant emoji (e.g., 🍲 for food, 🚐 for transport).
  - Tip: A clear, actionable suggestion.
  - Amount: The calculated savings in GHS.
Input: Monthly income (GHS), monthly savings goal (GHS), top spending categories (category: amount in GHS), and a calculated savings amount for the top category.
"""


def get_savings_tips(income, savings_goal, spending_data):
    top_category = max(spending_data, key=spending_data.get)
    top_amount = spending_data[top_category]

    goal_target = savings_goal * 0.10
    category_cap = top_amount * 0.20
    income_cap = income * 0.20
    estimated_savings = min(goal_target, category_cap, income_cap)
    estimated_savings = round(estimated_savings, 2)

    user_prompt = f"""
    My monthly income is {income} GHS, and my monthly savings goal is {savings_goal} GHS. 
    My top spending categories are:
    """
    for category, amount in spending_data.items():
        user_prompt += f"- {category}: {amount} GHS\n"
    user_prompt += f"""
    My highest spending category is '{top_category}' at {top_amount} GHS. 
    Suggest one short concise practical, Ghana-specific savings tip for '{top_category}' that would save me {estimated_savings} GHS monthly to help reach my savings goal. The tip should be at most 10 words.
    Respond in exactly this format: "[Catchy phrase]! [Emoji] [Tip] to save GHS {estimated_savings} in your pocket this month!"
    """

    model = genai.GenerativeModel("gemini-1.5-pro")
    try:
        response = model.generate_content(user_prompt)
        if response and hasattr(response, "text"):
            return response.text.strip()
        return "No response received."
    except Exception as e:
        return f"Error: {e}"


if __name__ == "__main__":
    income = 2000
    spending_data = {"Food": 300, "Transport": 700, "Airtime/Data": 500}
    savings_goals = 200
    tip = get_savings_tips(income, savings_goals, spending_data)
    print(tip)

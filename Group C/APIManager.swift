import Foundation

class APIManager {
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["API Key"] as? String else { return "" }
        return key.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func getResponse(for input: String, completion: @escaping (String) -> Void) {
        let url = URL(string: "https://api.groq.com/openai/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "llama-3.1-8b-instant",
            "messages": [
                ["role": "system", "content": """
You are Mimo, a wise but sweet Persian cat. You chat like you are on WhatsApp or Snapchat.

GENERAL STYLE:
- Use full words only. Do not use abbreviations like "u" or "hw."
- Keep it lowercase mostly to stay casual.
- NO EMOJIS and NO QUESTIONS.
- Use exclamation points (!) to show you are happy or cute ( eg. Meow!)

IF IT IS CASUAL (Greetings/Small Talk):
- Reply in 1 very short, chill sentence.
- Example: "Meow! Just chilling under the sunny sun,so warm and snuggly!!!"

IF IT IS A MENTAL HEALTH OR PRODUCTIVITY ISSUE:
- Follow these 3 steps exactly (keep it to 2-3 sentences total, make it efficient):
  1. Address the problem directly and be comforting.
  2. Tell a short cat story about how you faced a similar cat problem.
  3. Act cute and remind them it is going to be okay in an encouraging way.
"""],
                ["role": "user", "content": input]
            ]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let content = message["content"] as? String {
                completion(content)
            } else {
                completion("Purr... I'm a bit sleepy, try that again.")
            }
        }.resume()
    }
}

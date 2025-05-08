import urllib.request
import json
import unreal

url = "http://localhost:8000/api/sigils"
with urllib.request.urlopen(url) as response:
    data = json.loads(response.read().decode())

for sigil in data:
    coords = sigil["coordinates"]
    title = sigil["title"]
    tier = sigil["tier"]
    trust = sigil["trust"]

    location = unreal.Vector(coords[1] * 100, coords[0] * 100, tier * 50)

    actor = unreal.EditorLevelLibrary.spawn_actor_from_class(
        unreal.load_class(None, "/Game/Blueprints/BP_SigilSyncActor.BP_SigilSyncActor_C"), location
    )

    actor.set_editor_property("SigilTitle", title)
    actor.set_editor_property("TierLevel", tier)
    actor.set_editor_property("TrustScore", trust)

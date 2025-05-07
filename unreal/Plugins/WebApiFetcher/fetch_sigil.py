import requests
import unreal

# Fetch sigil data from API
sigils = requests.get("http://localhost:8000/api/sigils").json()

for sigil in sigils:
    title = sigil.get("title", "Untitled")
    coords = sigil.get("coordinates", [-95.3698, 29.7604])
    tier = sigil.get("tier", 0)
    trust = sigil.get("trust", 0.5)

    # Convert lon/lat to UE X/Y (simple scale for now)
    location = unreal.Vector(coords[1] * 100, coords[0] * 100, tier * 100)

    # Spawn the actor
    actor = unreal.EditorLevelLibrary.spawn_actor_from_class(
        unreal.load_class(None, "/Game/Blueprints/BP_SigilSyncActor.BP_SigilSyncActor_C"), location)

    # Set custom Blueprint exposed variables
    actor.set_editor_property("SigilTitle", title)
    actor.set_editor_property("TierLevel", tier)
    actor.set_editor_property("TrustScore", trust)

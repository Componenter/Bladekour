// Grapple types

export interface GrappleData {
	GrappleEventType: string;
	MousePosition3DSpace?: Vector3;
	MouseHitPart?: BasePart;
}

export interface VisualizeGrappleRopeData {
	hitPosition: Vector3;
	Player: Player;
}

package dee.moly.AI {
	
	/**
	 * Basic AI for firing projectiles. Starts with a random guess and improves
	 * itself with each turn.
	 * @author moly
	 */
	
	public class ProjectileEstimator{
		
		private var currentAngleGuess:int;
		private var currentVelocityGuess:int;
		
		public function ProjectileEstimator() {
			reset();
		}
		
		public function reset():void {
			currentAngleGuess = Math.random() * 30 + 40;
			currentVelocityGuess = Math.random() * 30 + 40;
		}
		
		public function getAngle():int {
			return currentAngleGuess;
		}
		
		public function getVelocity():int {
			return currentVelocityGuess;
		}
		
		// revise the current guess based on how far away the projectile
		// landed from the target
		public function projectileLanded(xDist:int, yDist:int):void {
			
			currentVelocityGuess -= xDist / 30;
			if (currentAngleGuess > 45)
				currentAngleGuess += xDist / 50;
			else if (currentAngleGuess < 45)
				currentAngleGuess -= xDist / 50;
			
		}
		
	}

}
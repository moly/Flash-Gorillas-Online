package dee.moly.textures {
	
	import flash.display.BitmapData;
	
	/**
	 * some drawing algorithms
	 * @author moly
	 */
	
	public class DrawingBitmap extends BitmapData{
		
		public function DrawingBitmap(width:int, height:int, transparent:Boolean, colour:uint) {
			
			super(width, height, transparent, colour);
			
		}
		
		// line drawing algorithm
		protected function line(x0:int, y0:int, x1:int, y1:int, colour:uint):void {
			
			var steep:Boolean = Math.abs(y1 - y0) > Math.abs(x1 - x0);
			
			if (steep){
				x0 += y0; y0 = x0 - y0; x0 -= y0;
				x1 += y1; y1 = x1 - y1; x1 -= y1;
			}
			if (x0 > x1){
				x0 += x1; x1 = x0 - x1; x0 -= x1;
				y0 += y1; y1 = y0 - y1; y0 -= y1;
			}
			
			var deltax:int = x1 - x0;
			var deltay:int = Math.abs(y1 - y0);
			var error:int = deltax / 2;
			var ystep:int;
			var y:int = y0;
			
			if (y0 < y1)
				ystep = 1;
			else
				ystep = -1;
				
			for (var x:int = x0; x <= x1; x++) {
				
				if (steep)
					setPixel32(y, x, colour);
				else
					setPixel32(x, y, colour);
					
				error -= deltay;
			
				if (error < 0){
					y += ystep;
					error += deltax;
				}
				
			}
			
		}
		
		// qbasic-ish "circle" drawing algorithm.
		protected function circle(x:int, y:int, radius:int, colour:uint):void {
		
			var px:int, py:int, xRadius:int, yRadius:int, xChange:int, yChange:int;
			var ellipseError:int, twoASquare:int, twoBSquare:int, stoppingX:int, stoppingY:int;
			
			xRadius = radius;
			yRadius = radius * 0.8;
			twoASquare = 2 * xRadius * xRadius;
			twoBSquare = 2 * (yRadius) * (yRadius);
			px = radius;
			py = 0;
			xChange = (yRadius) * (yRadius) * (1 - 2 * xRadius);
			yChange = xRadius * xRadius;
			ellipseError = 0;
			stoppingX = twoBSquare * xRadius;
			stoppingY = 0;
			
			while (stoppingX >= stoppingY ){
				plot4EllipsePoints(x, y, px, py, colour);
				py++;
				stoppingY += twoASquare;
				ellipseError += yChange;
				yChange += twoASquare;
				if ((2 * ellipseError + xChange) > 0 ){
					px--;
					stoppingX -= twoBSquare;
					ellipseError += xChange;
					xChange += twoBSquare;
				}
			}
			
			px = 0;
			py = (yRadius);
			xChange = (yRadius) * (yRadius);
			yChange = xRadius * xRadius * (1 - 2 * (yRadius));
			ellipseError = 0;
			stoppingX = 0;
			stoppingY = twoASquare * (yRadius);
			
			while ( stoppingX <= stoppingY ){
				
				plot4EllipsePoints(x, y, px, py, colour);
				px++;
				stoppingX += twoBSquare;
				ellipseError += xChange;
				xChange += twoBSquare;
				if ((2 * ellipseError + yChange) > 0 ){
					py--;
					stoppingY -= twoASquare;
					ellipseError += yChange;
					yChange += twoASquare;
				}
			}
		
		}
		
		private function plot4EllipsePoints(x:int, y:int, px:int, py:int, colour:uint):void{
			
			setPixel32(x + px, y + py, colour);
			setPixel32(x - px, y + py, colour);
			setPixel32(x - px, y - py, colour);
			setPixel32(x + px, y - py, colour);
			
		}
		
	}

}
function Venue  = setVenue(Venue)
[Venue.Plane.x, Venue.Plane.N1, Venue.Plane.N2] = getxPlane(Venue.Plane.xPl, Venue.Plane.yPl);
%[Venue.Aud.x] = getxPoints(Venue.Aud.xStart, Venue.Aud.xStop,Venue.Aud.N);
[Venue.Aud.x] = getxPoints_dx(Venue.Aud.xStart, Venue.Aud.xStop,Venue.Aud.dx);
%[Venue.Avoid.x] = getxPoints(Venue.Avoid.xStart, Venue.Avoid.xStop,Venue.Avoid.N);
[Venue.Avoid.x] = getxPoints_dx(Venue.Avoid.xStart, Venue.Avoid.xStop,Venue.Avoid.dx);
[Venue.FRP.x, Venue.FRP.phi] = getxFRP(Venue.FRP.xM, Venue.FRP.rFar, Venue.FRP.dphi_deg);
end


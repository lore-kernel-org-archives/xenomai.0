From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 25 Feb 2006 21:31:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602252131.05088.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Problems accessing
	svn://svn.gna.org/svn/xenomai/trunk
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

Calling svn update complained always with "Malformed network data".

After switching from using svn: to using http: to access the xenomai 
repository (called svn switch --relocate \ 
svn://svn.gna.org/svn/xenomai/trunk \
http://svn.gna.org/svn/xenomai/trunk) svn update worked fine. 

Can anybody confirm this? Or is the svn server down? 

-- 
Niklaus Giger


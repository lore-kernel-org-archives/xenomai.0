Message-ID: <435CA008.6060109@domain.hid>
Date: Mon, 24 Oct 2005 11:49:12 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH: 0/3] powerpc merge
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Merge 32- and 64-bit powerpc architectures into a common powerpc arch in 
anticipation of the similar merge happening in linux kernel (possible in 
2.6.15). Amount of shared code between 32- and 64-bit ppc is substantial 
and I don't see anything changing that. These patches will simplify 
maintenance. In case the mailing list rejects the largish attachments 
I'll see if I can use the patch tracker in gna instead.

-- Heikki Lindholm


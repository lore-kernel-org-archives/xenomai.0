Resent-To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Resent-Message-Id: <48B55FE5.4040608@domain.hid>
Message-ID: <48B5592B.1090005@domain.hid>
Date: Wed, 27 Aug 2008 15:39:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH 0/3] Handle-based fast mutex owner
	tracking
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Gilles,

this is a prototype patch series to explore handle-based lock owner
tracking in the fast mutex lock variable. It appears to work, so I'm
rolling it out for collecting early comments, specifically from you.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux



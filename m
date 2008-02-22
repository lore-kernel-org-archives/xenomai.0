Message-ID: <2ff1a98a0802220219u16014e53p9f145b485525fbbb@domain.hid>
Date: Fri, 22 Feb 2008 11:19:01 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-core] User-space real-time allocator.
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

Hi,

I am currently porting a C++ application (sems to name it) to run some
part of its work (handling RTP streams) in primary mode with Xenomai.

The problem is that this application uses the STL so does some
allocations with STL allocator.

So, I was wondering, by any chance, has somebody implemented a
real-time version of these STL allocators ? Maybe people from the
xeno-- project ?

-- 
                                               Gilles Chanteperdrix


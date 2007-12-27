MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18290.62470.714603.940223@domain.hid>
Date: Thu, 27 Dec 2007 01:38:30 +0100
In-Reply-To: <2ff1a98a0712200643u797cfad2ve3848d88feda3bea@domain.hid>
References: <2ff1a98a0712200643u797cfad2ve3848d88feda3bea@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Auto closing of file descriptors and fork.
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

Gilles Chanteperdrix wrote:
 > Hi,
 > 
 > I have a problem with auto closing of file descriptors and fork. I
 > have an application (a modified pppd, to name it), which in a certain
 > mode (pppd "updetach" mode) opens some real-time file descriptors,
 > forks and exit the parent, continuing to use the file descriptors in
 > the child. The problem is that when exiting the parent, file
 > descriptors are automatically destroyed and therefore can not be used
 > in the child.
 > 
 > Any ideas for a fix ?

More precisely. We need to trap the "fork" event, and handle it in the
skins event callbacks. We will need to create a new ppd structure for
the new process, but what will we do with the skin objects ? If we keep
the same objects for the child and increment a reference count, we will
end up with an object that need to be inserted in two per-process
lists. If we create new objects, how will we manage for user-space
references (inherited accross fork) to remain valid ?

-- 


					    Gilles Chanteperdrix.


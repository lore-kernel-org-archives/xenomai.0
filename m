Message-ID: <4463BD9C.8030505@domain.hid>
Date: Fri, 12 May 2006 00:41:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Errors running sim testsuite for vxWorks
References: <200605111823.51650.niklaus.giger@domain.hid>
	<17507.27519.455277.534105@domain.hid>
In-Reply-To: <17507.27519.455277.534105@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:

> 
>  > Is it normal that a "make check" only works, if one builds the simulator 
>  > inside the source code?
> 
> Last time I checked it worked when built out-of-tree, but you must build
> the simulator in the sim subdirectory of a xenomai build directory.

It should not be necessary, at least I don't build it this way and it 
works. This is not a guarantee of success for the "make check" issue though.

-- 

Philippe.


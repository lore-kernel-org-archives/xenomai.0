Message-ID: <488D8FC5.3030208@domain.hid>
Date: Mon, 28 Jul 2008 11:22:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <894886ec0807242231t44d37de6q4c23b02ae67d3bb8@domain.hid>
In-Reply-To: <894886ec0807242231t44d37de6q4c23b02ae67d3bb8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] nofastsem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Wheeler <wheeler@domain.hid>
Cc: xenomai@xenomai.org

Rob Wheeler wrote:
> I've been running revision 4007 from the Xenomai svn trunk
> successfully, and I recently tried building and running a more recent
> revision (4060).  The kernel and user code all build fine, but when I
> try to run a Xenomai application I get a message saying the userland
> wants fastsem and the kernel has nofastsem.  I'm not able to locate an
> option in the kernel (2.6.24.3) to enable fastsem, nor do I see an
> option in Xenomai's menuconfig to allow nofastsem.  What am I missing?
> 
> Thanks in advance...

This fastsem stuff for x86_32 contained several mistakes, all of them
hopefully corrected now. Resync, and it should get better.

-- 
                                                 Gilles.


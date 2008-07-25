Message-ID: <488990B0.3010209@domain.hid>
Date: Fri, 25 Jul 2008 10:37:04 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <894886ec0807242231t44d37de6q4c23b02ae67d3bb8@domain.hid>
In-Reply-To: <894886ec0807242231t44d37de6q4c23b02ae67d3bb8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

There is a new option since rev. 4043 called XENO_FASTSEM. It is set by 
default for x86_32. Have a look at your kernel config file and search 
for that term. Please make sure that you build your xenomai-patched 
kernel and you userland libs and applications with the same revision of 
xenomai and don't forget to install them all on your target.

BTW, for which architecture are you building xenomai?

-- 
Sebastian


MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17891.16252.750237.419469@domain.hid>
Date: Mon, 26 Feb 2007 21:13:48 +0100
Subject: Re: [Xenomai-help] newby question, can/socket stuff
In-Reply-To: <bc4264770702261158m3c55e540r914f4839bbf11e5d@domain.hid>
References: <bc4264770702261108l6b3f60b2w53e9e90e40d79b92@domain.hid>
	<17891.12915.944793.970838@domain.hid>
	<bc4264770702261158m3c55e540r914f4839bbf11e5d@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
 > >
 > > And follow the links, you will arrive at:
 > > http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html
 > 
 > Actually this is where I had been spending most of my time before
 > posting my mail.
 > 
 > I must be blind because I really do not see anything remotely
 > resembling functions like:
 > 
 > rt_dev_ioctl(arg1, arg2, and maybe arg 3 don;t know off by heart anymore)
 > 
 > Are you sure the above is the link I must look at?

Yes, Ok, you need a bit of knowledge of how ioctl works. The first
argument is the socket/file descriptor, the second argument is a
command, and the third argument an argument to that command.

The commands are those listed in the section entitled "IOCTLs". Now, if
you read:
#define SIOCGIFINDEX   _IOWR(RTIOC_TYPE_CAN, 0x00, struct ifreq)

You are supposed to understand that SIOCGIFINDEX is a valid command,
that the argument of this command is a pointer to a "struct ifreq", and
that this command reads and writes to this structure. Since the text
below this define is "Get CAN interface index by name", you should
understand that you have to use it that way:

struct ifreq ir;
ir.ifr_name = "rtcan0";
rt_dev_ioctl(socket, SIOCGIFINDEX, &ir);
index = ir.ifr_ifindex;

-- 


					    Gilles Chanteperdrix.


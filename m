Message-ID: <45798896.5070506@domain.hid>
Date: Fri, 08 Dec 2006 17:45:26 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] I/O privilege losted and killed message
References: <s577092a.032@domain.hid>
In-Reply-To: <s577092a.032@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nicolas BLANCHARD <n.blanchard@domain.hid>
Cc: xenomai@xenomai.org

I also can confirm that rt-tasks sometimes lost I/O privileges.

My code was based on 
http://www.captain.at/xenomai-parallel-port-interrupt.php, but is was 
not stable (most worse is program was
I had to use outb instead of outb_p, ioperm instead of iopl and move 
permission requesting function (ioperm) to 'task' function body.



-- 
________________________________________
Maksym Veremeyenko



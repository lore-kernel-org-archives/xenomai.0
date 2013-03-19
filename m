Message-ID: <51482868.5020206@wanadoo.fr>
Date: Tue, 19 Mar 2013 09:57:12 +0100
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Limited kernel size for booting ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,

First, I apologize for posting such a question that is sincerely not 
really related to xenomai.
But I am using the kernel from ipipe-gch.git, branch ipipe-3.0-imx6q

The issue I have is that it is not booting when using a really big 
built-in initramfs(about 60 Mo)
It does not seem to reach "start_kernel", there is nomore log after 
Uboot says "Starting kernel"

I have payed attention to address zones, and even tried to use an 
uncompressed kernel
in the uImage container, to skip and discriminate the gzip phase. Same 
result.

I do not have an operational Jtag probe yet, thus I only would like to 
get your opinion on
this. To your mind, is this assumed to work ?

Thanks in advance for any clues on that "out of scope" request.

Cheers
Thierry

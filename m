Message-ID: <5130DF36.5090606@siemens.com>
Date: Fri, 01 Mar 2013 18:02:46 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com> <512C9E78.1060208@siemens.com>
	<512CC5C6.8050204@hilscher.com> <512CC6A3.1010005@siemens.com>
	<512F120A.5060109@hilscher.com> <512F4005.60000@siemens.com>
	<512F48AA.8020601@hilscher.com> <5130B39C.70300@hilscher.com>
In-Reply-To: <5130B39C.70300@hilscher.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerome Poncin <JPoncin@hilscher.com>
Cc: xenomai@xenomai.org

On 2013-03-01 14:56, Jerome Poncin wrote:
> Hello,
> 
> I finished to reformat my driver according to kernel coding style.
> 
> I'm compiling no version to test it ;-) !
> 
> I'm ready to do a patch against Xenomai git head. The patch will add the
> driver source
> code under ksrc/drivers/cifx and change the Makefiles and Kconfigs as
> required.
> 
> I did this command to get Xenomai git head :
> 
> git clone git://git.xenomai.org/xenomai-head.git xenomai-head
> 
> but connexion is refused. What must I do to clone Xenomai git head and
> do my patch ?

Try via http://, git is apparently broken ATM.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux


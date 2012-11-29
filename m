Message-ID: <50B74521.9010808@grandegger.com>
Date: Thu, 29 Nov 2012 12:21:05 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <50B739B8.9090509@mediso.hu>
In-Reply-To: <50B739B8.9090509@mediso.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] MPC5200 MSCAN GPIO routing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Bukuli <norbert.bukuli@mediso.hu>
Cc: xenomai@xenomai.org

On 11/29/2012 11:32 AM, Norbert Bukuli wrote:
> Hello all,
> 
> I missed the GPIO routing functionality of MSCAN in MPC5200.
> Please check the attached patch, whether is it usable.

Unfortunately, the attachment is missing. Anyway, the proper GPIO
routing should be setup either by the boot loader or by platform code
(in arch/powerpc/platforms/52xx). That's why we do not have it anymore
in the driver.

Wolfgang.




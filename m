Message-ID: <48E506A5.4000406@domain.hid>
Date: Thu, 02 Oct 2008 19:36:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <899865CA54E4444DAF2E3639C04C5F48E4DB5C@trillian.at.omicron.at>
	<48E4E8FB.1050901@domain.hid>
In-Reply-To: <48E4E8FB.1050901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] FW: [PATCH] repost: ARM FCSE
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: adeos-main@gna.org

Gilles Chanteperdrix wrote:
> Something else I needed was that the cache flush do not rely on
> mm->cpu_vm_mask to flush. So, we basically wanted that the cpu bit be
> set in cpu_vm_mask unconditionnaly when the context is switched first to
> the new process, and not cleared in switch_to when the process is
> switched out.

A side effect of this, is that va_to_mva had to be changed to use the
pid of a given mm instead of using the current mm pid.

Other cosmetic changes were to rename asm/pid.h asm/fcse.h, and prefix
all fcse functions with fcse_ to avoid namespace pollution and so that
it appears clearly in the source what fcse uses.

-- 
					    Gilles.


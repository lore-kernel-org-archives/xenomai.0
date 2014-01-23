Message-ID: <52E109CD.7070405@xenomai.org>
Date: Thu, 23 Jan 2014 13:23:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52DF9C5F.70005@geral.com> <52DFAA18.6080703@xenomai.org>
 <52DFAD29.4000800@geral.com> <52DFB2DE.4050501@xenomai.org>
 <52DFC734.2090906@geral.com> <52DFC80D.6050101@xenomai.org>
 <52DFCFDE.9060700@geral.com> <52DFD1B0.6070303@xenomai.org>
 <52E0E93C.8010209@xenomai.org>
 <1bab8396d7c946110418979cb8177d9b@grandegger.com>
 <52E10594.4010901@xenomai.org>
 <891daa591ae64f3c75be1bf430782be1@grandegger.com>
In-Reply-To: <891daa591ae64f3c75be1bf430782be1@grandegger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] imx28 rtcan flexcan system freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Wolfgang Grandegger <wg@denx.de>, xenomai@xenomai.org

On 01/23/2014 01:21 PM, Wolfgang Grandegger wrote:
>> Vanilla handles the alignment trap by emulating the faulting
>
>> instruction. Last time I checked, there were some problems related to
>
>> running the emulation over xenomai domain, though looking at the code
>
>> now, I see nothing which would prevent us from doing it.
>
>
>
> Yes, I know. But the handling of unaligned accesses via trap handler must
>
> be
>
> enabled by the user and I'm not aware that this is needed for vanilla
>
> Linux.

I remember reading on the LAKML that the alignment trap is needed for 
kernel operations, notably for the IP stack.

-- 
					    Gilles.


Message-ID: <52CF3B64.8060705@xenomai.org>
Date: Fri, 10 Jan 2014 01:14:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org> <52CC62A0.3090108@xenomai.org>
 <44lhyqgkip.fsf@lowell-desk.lan> <52CDDCEC.6030205@xenomai.org>
 <44wqi9hvx6.fsf@lowell-desk.lan>
In-Reply-To: <44wqi9hvx6.fsf@lowell-desk.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Altera Cyclone V
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

On 01/09/2014 07:06 PM, Lowell Gilbert wrote:
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
> 
>> No, you do not have to write your own __ipipe_mach_update_tsc(). See:
>> https://www.xenomai.org/index.php/I-pipe-core:ArmPorting#High_resolution_counter
> 
> I appreciate the help, but I still don't see an implementation
> of __ipipe_mach_update_tsc() that I could have used.
> Where was I supposed to get it from?

Simply select IPIPE_ARM_KUSER_TSC and everything gets taken care of
automatically. Since I suppose you read the documentation and did that,
I guess you have a problem. Could you explain us exactly what problem
you have?


-- 
                                                                Gilles.


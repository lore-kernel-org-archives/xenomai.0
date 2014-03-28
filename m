Message-ID: <53358879.2040109@xenomai.org>
Date: Fri, 28 Mar 2014 15:34:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgn=VM340xozWgS=8aap5Wkw2YCynGDSwtj9m1415J+XYw@mail.gmail.com>
 <44ha6j7j1j.fsf@lowell-desk.lan> <53346FF7.9010509@xenomai.org>
 <CAEbDrg=K=soaY9rV2GizdMANz8PKDGsLguCnb4Jh_iLuhqbLig@mail.gmail.com>
In-Reply-To: <CAEbDrg=K=soaY9rV2GizdMANz8PKDGsLguCnb4Jh_iLuhqbLig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raspberry Pi - 3.10.34
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/28/2014 03:22 PM, Gregory Dymarek wrote:
> Ok, I think I'm on top of it. Will post all the patches once I test
> them properly.
>
> Another question on the topic of PRE and POST patches. Is there a
> reason why prepare-kernel.sh cannot invoke PRE and POST patches
> automatically?
>
> I'm trying to get this into a buildroot and it does not support pre
> and post patches. Also, I'm getting a push back on adding the support
> for pre- and post- ipipe patches into buildroot.

No reason except the fact that -pre and -post patches are a temporary 
solution while the support for the board is integrated into the mainline 
kernel. Now, given the evolution pace of ARM platforms, it seems we will 
always have -pre and -post patches, so it would make sense to add this 
support to prepare-kernel.sh. So, the answer to your question is "patch 
welcome".


-- 
					    Gilles.


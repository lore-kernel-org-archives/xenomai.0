Message-ID: <521D167C.7070801@xenomai.org>
Date: Tue, 27 Aug 2013 23:13:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52138425.2030000@steinkuehler.net> <5213B7D3.5030606@xenomai.org>
	<5213C836.403@steinkuehler.net> <5213C9AD.2010903@xenomai.org>
	<5213D09E.80103@steinkuehler.net> <5214BDC1.30104@steinkuehler.net>
	<5215061E.6060305@xenomai.org> <521D053B.7010005@steinkuehler.net>
	<521D1631.6030006@xenomai.org>
In-Reply-To: <521D1631.6030006@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] BeagleBone 3.8.13 pre/post patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 08/27/2013 11:12 PM, Gilles Chanteperdrix wrote:
> On 08/27/2013 09:59 PM, Charles Steinkuehler wrote:
>> I made a pre/post patch set for the BeagleBone 3.8.13 kernel and added
>> the files to my xenomai 2.6 repository (patch attached).
>>
>> Note that I just added the files...I didn't do anything to try and
>> integrate these with the prepare_kernel.sh script (since I'm applying
>> the ipipe patch from git manually) or add documentation.  With this, the
>> patch generated from the current git ipipe-3.8 branch applies cleanly.
>>
>> Anyway, the patch turned out to be quite simple and will hopefully roll
>> forward fairly well.
> 
> Hi, thanks for the patch. The prepare-kernel script does not apply pre
> and post patches automatically, but this could be arranged. The key
> information to add to the documentation is the I-pipe repository/branch
> and commit hash to which the patch applies.

I mean the git repository/branch and commit hash.

-- 
                                                                Gilles.


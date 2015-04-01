Message-ID: <551BEB62.7030901@xenomai.org>
Date: Wed, 01 Apr 2015 14:58:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1YdHjz-0005Rv-A3@sd-51317.xenomai.org>
 <20150401125148.GA29467@hermes.click-hack.org>
In-Reply-To: <20150401125148.GA29467@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : Create gitignore for
 autotools files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 04/01/2015 02:51 PM, Gilles Chanteperdrix wrote:
> On Wed, Apr 01, 2015 at 02:27:27PM +0200, git repository hosting wrote:
>> Module: xenomai-jki
>> Branch: for-forge
>> Commit: 519962c23a696aba736d8b535c8f1a00382dae8b
>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=519962c23a696aba736d8b535c8f1a00382dae8b
>>
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Wed Apr  1 14:25:42 2015 +0200
>>
>> Create gitignore for autotools files
>>
>> This avoids filling up "git status" with tones of autotools files that
>> are now locally maintained.
> 
> I am not sure having a gitignore file in the repository is a good
> idea, for instance, it will conflict with the gitignore I already
> had, because not using the same autotools version as Philippe, my
> git status was already filled with tons of autotools files without a
> gitignore and before they were removed from the repository. I also
> like to add files to gitignore like *~ my editor creates, and so if
> my gitignore has local modifications, I will see it in the git
> status too.
> 

I'd rather refrain from forcing .gitignore on users too, what to filter
out should remain a local policy. However, we could provide a sane
default template for this file if that helps, e.g. scripts/gitignore.dot.

-- 
Philippe.


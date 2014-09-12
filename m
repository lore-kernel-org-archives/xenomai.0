Message-ID: <541348C6.8080501@xenomai.org>
Date: Fri, 12 Sep 2014 21:25:58 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1XSVv1-0006Fm-8S@sd-51317.dedibox.fr>
 <54134145.1000502@xenomai.org>
In-Reply-To: <54134145.1000502@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : testsuite/smokey: cope
 with missing fork() in fork-exec test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 09/12/2014 08:53 PM, Gilles Chanteperdrix wrote:
> On 09/12/2014 08:50 PM, git repository hosting wrote:
>> Module: xenomai-forge
>> Branch: next
>> Commit: 7b3ca1acdae56521c11f3bbcd8df7d57d781cb7c
>> URL:    http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=7b3ca1acdae56521c11f3bbcd8df7d57d781cb7c
>>
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Thu Sep 11 08:55:19 2014 +0200
>>
>> testsuite/smokey: cope with missing fork() in fork-exec test
>>
>> We still use fork() when present, in order to check for
>> the several pthread_atfork() handlers we have in libcobalt.
> 
> I believe the pthread_atfork() handlers are also called with vfork.
> 
> 

Only with linuxthreads. NPTL disables this.


-- 
Philippe.


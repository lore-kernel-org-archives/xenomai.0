From: Steve Hartmann <shartmann@cnt.canon.com>
Date: Wed, 8 Oct 2014 18:48:00 +0000
Message-ID: <D05AE639.193F6%shartmann@cnt.canon.com>
References: <D059B455.193D3%shartmann@cnt.canon.com>
 <20141007203650.GC1685@sisyphus.hd.free.fr>
 <20141007204510.GD1685@sisyphus.hd.free.fr>
In-Reply-To: <20141007204510.GD1685@sisyphus.hd.free.fr>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2CB89182026464DA2B98AF420897AA0@mex06.mlsrvr.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] SIGXCPU on pthread_mutex_unlock()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>



On 10/7/14 3:45 PM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

>On Tue, Oct 07, 2014 at 10:36:50PM +0200, Gilles Chanteperdrix wrote:
>> On Tue, Oct 07, 2014 at 08:16:39PM +0000, Steve Hartmann wrote:
>> > Hi folks,
>> >
>> > I'm having an issue I hope someone here might be able to shed some
>>light on.
>> >
>> > I am running Xenomai 2.6.4 on linux 3.4.6.  The application has a
>>very large source base which was not originally designed for xenomai.
>>I am using xenomai because of some new requirements and the addition of
>>EtherLabs Ethercat master.
>> > So in one of the original threads, which is running at PRI 0,  I have
>>two mutexes which when unlocked throw a SIGXCPU signal.  These mutexes
>>are only locked/unlocked in this same thread.  I have seen this happen
>>when a mutex which is not locked has an unlock attempt.  This is not the
>>case for this issue.
>> >
>> > What could I be doing which would cause a pthread_mutex_unlock to
>>throw the SIGXCPU signal?  Any suggestions for troubleshooting
>>techniques?
>>
>> When you receive the SIGXCPU signal, you should check the reason as
>> demonstrated in the examples/native/sigdebug.c program.
>
>Or see:
>http://xenomai.org/2014/06/finding-spurious-relaxes/
>
>--
>					    Gilles.

Thanks for the hints.  I probably would have found it myself had I been
searching for SIGDEBUG instead of SIGXCPU.

Anyway, the reason I am getting a SIGDEBUG_RESCNT_IMBALANCE.  I did a
search and saw there were some changes between 2.6.2.1 and 2.6.4 regarding
the rescnt imbalance.  I just so happen to have two machines running this
same code - one on 2.6.2.1 and one on 2.6.4.  Only the one on 2.6.4
machine is throwing this signal.  Either the xenomai change introduced a
new bug, or the change in xenomai has exposed a bug in our code.  I have
reviewed our code and it seems to be correct.  I even threw in an extra
pthread_mutex_trylock (for troubleshooting) just before the
pthread_mutex_unlock and checked the return code just to make sure that it
is locked.  There are no instances where the extra trylock() actually
succeeded, which made me more confident that our code is correct.  The
mutex is not recursive.



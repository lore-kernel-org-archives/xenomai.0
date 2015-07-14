References: <1835626271.1735438.1436794640939.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55A4DC2F.1090608@xenomai.org>
Date: Tue, 14 Jul 2015 11:53:51 +0200
MIME-Version: 1.0
In-Reply-To: <1835626271.1735438.1436794640939.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/13/2015 03:37 PM, Frederik Bayart wrote:
> Hallo,
> 
> I have problems to bind named semaphores from an external process using
> the alchemy API.  Below a detailed description. Does anyone have a suggestion
> 
> what could be wrong or what I could do to solve the problem ?
> Kind regards,
> 
> Frederik
> 
> In attachment an example to reproduce my problem (makefile, stest.c).
> If you run 'sudo ./stest 1', a named semaphore is created and a task is started
> that binds it and perform a p operation. The main task is waiting on CTRL+C,
> and then ask the numer of waiters and performs v operations.
> If you run 'sudo ./stest 0', the named semaphore is not created, only a task is
> started that binds it and perform a p operation.
> 
> I start first 'sudo ./stest 1'. The process binds the semaphore and blocks on rt_sem_p.
> The content of /var/run/xenomai is :
> 

[snip]

The key issue is that multiple programs forming a single application
must belong to the same Xenomai session, for sharing data/objects. The
notion of "session" was introduced by Xenomai 3.

So, all you need to do, is to tell the application bootstrap code about
the session you want to create between several programs, e.g.:

# ./stest --session=foo 1
# ./stest --session=foo 0

-- 
Philippe.


References: <447fdp9oue.fsf@be-well.ilk.org>
 <0b7ab1b8-8d53-069a-49b6-a3f289c0b43c@xenomai.org>
 <441t3rlwfe.fsf@be-well.ilk.org>
 <20160620152246.GA18662@hermes.click-hack.org>
 <44wpljkchx.fsf@be-well.ilk.org>
 <20160620171848.GB18662@hermes.click-hack.org>
 <44h9cmz8y1.fsf@be-well.ilk.org> <44d1naz7ub.fsf@be-well.ilk.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b436e690-79d6-0de7-647a-1ec5c80ae4d9@xenomai.org>
Date: Tue, 21 Jun 2016 21:27:38 +0200
MIME-Version: 1.0
In-Reply-To: <44d1naz7ub.fsf@be-well.ilk.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] slackspot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>, xenomai@xenomai.org

On 06/21/2016 08:59 PM, Lowell Gilbert wrote:
> Lowell Gilbert <kludge@be-well.ilk.org> writes:
> 
>> I'm attaching a tar file, but in case this list strips attachments, it's
>> also at
>>  http://be-well.ilk.org/~lowell/example.tar
>> It's about a hundred lines each for the application and kernel module.
> 
> I have updated the tarball with a missing header file.
> 
> This time, I *tested* the tarball.
> I apologize for the oversight.
> 

No problem, we are doing this all the time. Actually Xenomai is most
likely a massive collection of oversights that tend to be working well
together.

You app is missing a call to pthread_setmode_np() for enabling the
warn-upon-switch bit,
e.g. calling pthread_set_mode_np(0, PTHREAD_WARNSW, NULL) would enable
tracing for the calling thread.

http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api__thread.html#gae3b7df7f77c04253ed19fb6346f0f9b2

-- 
Philippe.


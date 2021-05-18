Subject: Re: arm/arm64 ipipe performance
References: <CALLqZ8SWfJqE64RfNfK-OXcj0mdWnU+5tTT9ABmMa-rz9QHZnA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <82f01d0d-360b-0016-9aec-24ef5b1a8d6b@siemens.com>
Date: Tue, 18 May 2021 20:49:28 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8SWfJqE64RfNfK-OXcj0mdWnU+5tTT9ABmMa-rz9QHZnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 18.05.21 20:28, Greg Gallagher via Xenomai wrote:
> Hi Everyone,
>    There's been a noticeable slow down in the arm and arm64 latency of
> late.  I tracked the issue
>  down to the tracing infrastructure.  For now if you hit this issue,
> disable ftrace.  Once this is done the latency numbers look much better.
> I'm currently working on resolving the issue.

Do you mean disabling during build? Or is the issue only present when
tracing is actively used during runtime?

> 
>   New patches will be released this week for both arm and arm64 now that
> the issue is understood and a work around exists.
> 

That's great!

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


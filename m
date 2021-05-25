MIME-Version: 1.0
In-Reply-To: <CALLqZ8SWfJqE64RfNfK-OXcj0mdWnU+5tTT9ABmMa-rz9QHZnA@mail.gmail.com>
References: <CALLqZ8SWfJqE64RfNfK-OXcj0mdWnU+5tTT9ABmMa-rz9QHZnA@mail.gmail.com>
From: liandao <liandao@gmail.com>
Date: Tue, 25 May 2021 18:43:54 +0800
Message-ID: <CAMC3Yu0FizU008EE9RNB+jMZUxeg8R-u+7v4FGCFjLsLP7aRFg@mail.gmail.com>
Subject: Re: arm/arm64 ipipe performance
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

hi greg gallagher,
    is this mean:the ipipe-core-5.4.119-arm64-2 released on 5/23 also
should turn off ftrace when config kernel?

On 5/19/21, Greg Gallagher via Xenomai <xenomai@xenomai.org> wrote:
> Hi Everyone,
>    There's been a noticeable slow down in the arm and arm64 latency of
> late.  I tracked the issue
>  down to the tracing infrastructure.  For now if you hit this issue,
> disable ftrace.  Once this is done the latency numbers look much better.
> I'm currently working on resolving the issue.
>
>   New patches will be released this week for both arm and arm64 now that
> the issue is understood and a work around exists.
>
> Thanks
>
> Greg
>


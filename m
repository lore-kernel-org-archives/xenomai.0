MIME-Version: 1.0
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 18 May 2021 14:28:15 -0400
Message-ID: <CALLqZ8SWfJqE64RfNfK-OXcj0mdWnU+5tTT9ABmMa-rz9QHZnA@mail.gmail.com>
Subject: arm/arm64 ipipe performance
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Everyone,
   There's been a noticeable slow down in the arm and arm64 latency of
late.  I tracked the issue
 down to the tracing infrastructure.  For now if you hit this issue,
disable ftrace.  Once this is done the latency numbers look much better.
I'm currently working on resolving the issue.

  New patches will be released this week for both arm and arm64 now that
the issue is understood and a work around exists.

Thanks

Greg

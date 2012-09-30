Message-ID: <50681D48.7050209@xenomai.org>
Date: Sun, 30 Sep 2012 12:22:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdinbdLC7uBFu9Yyq6aWvJOQj5HEOKEd+pyAPObQ_ZH1g@mail.gmail.com>	<5066E73D.6010704@xenomai.org>	<CAKKWdtckyrV=FCM6-ru=WqMXL0zkUCPBA=Dsbn6qYw0N7LvmEg@mail.gmail.com>	<506818E5.5010709@xenomai.org>
	<CAKKWdtfPdBvupEzkbdfxKYoSR7O_k42QN-gXNphr=uiYEhjsPA@mail.gmail.com>
In-Reply-To: <CAKKWdtfPdBvupEzkbdfxKYoSR7O_k42QN-gXNphr=uiYEhjsPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question about latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 09/30/2012 12:17 PM, ali hagigat wrote:

> are gatekeeper threads, Linux tasks or they are  xenomai tasks?


You see them when running ps, so they are handled by the Linux
scheduler. You see them enclosed in square brackets, so they are kernel
threads.

-- 
                                                                Gilles.


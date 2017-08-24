MIME-Version: 1.0
From: George Broz <brozgeo@gmail.com>
Date: Thu, 24 Aug 2017 08:38:29 -0700
Message-ID: <CAMcKmiHUHPdgg0avFpz+RWi4r6gFDNXdLtOT2vQu1VchnkHs8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] undefined symbol __wrap_malloc in 3.0.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi ,

I am trying to run an application in Xenomai 3.0.4 that was previously running
fine in Xenomai 3.0.2.

On startup of the application, I get the message:
./my_app: symbol lookup error: ./my_app: undefined symbol: __wrap_malloc

(which terminates the application.)

I noticed that malloc and free are missing from the cobalt.wrappers in 3.0.4.
They are now in "modechk.wrappers"

I saw that a xeno-config option was added (--no-mode-check/--mode-check) .
I have added this to my link flags for the application. I have tried
both options
and I still get the same undefined symbol message on startup.

Can someone please tell me how I can build the application to now find
these wrappers? Does it require a Xenomai kernel configuration option to
be selected as well?


Thanks in advance!

--George Broz
Moog Industrial Group


MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Fri, 17 Aug 2018 18:56:55 +0530
Message-ID: <CAOuPNLgkFZ7wwBM2N3HXYSh0fkGce8GytJdKHnbsmBN4zfwcFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] message pipe stream test application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I wanted to understand how rt_pipe_stream works and how it can be useful.
I wanted to create a demo application using it.
But currently I could not figure out how to make use of it.

I saw a sample pipe application under: lib/alchemy/testsuite/pipe-1.c.
Based on this I am trying to create a new application that uses rt_pipe_stream.
The rt_pipe_stream is working fine, but I wanted to test the scenario
based on its description.

My understanding is that:
Regular thread keeps write one by one char to rtipc, and the real-time
task reads one char at a time. Then real-time task call rt_pipe_stream
which keeps storing the char.
Finally, when regular thread calls "read" then all the data from
stream will be read by the regular thread at once.

Hope my understanding is correct.
I want to prepare a sample application for the same.

If any reference for rt_pipe_stream is available please let me know.


Thanks,
Pintu


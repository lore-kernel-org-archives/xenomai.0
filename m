MIME-Version: 1.0
Date: Sat, 23 Nov 2013 18:46:11 +0330
Message-ID: <CAKKWdtchCb5BeK4xLpEyUot5960Cx9HA87g+L=7UzQTfpyYsFg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] a question about the Xenomai functionality when page
	fault exception
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

If a Xenomai task is created , i think not all of the pages of that
task has been allocated inside the physical memory, so sooner or later
that task is faced with "page fault exception".
"page fault exception"  is handled by Linux kernel by default, so
executing that exception may be delayed even up to 4 seconds when
Linux executes and there is no other real time task.

Is the above idea correct? is it possible for a Xenomai task to
experience a long delay because of a page fault exception?

Thank you so much in advance to read my question.

Regards


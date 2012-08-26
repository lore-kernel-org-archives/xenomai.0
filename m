MIME-Version: 1.0
Date: Sun, 26 Aug 2012 11:09:10 +0430
Message-ID: <CAKKWdtdkC=0f7zJUNkfxwON0N+Vve6eXtjY7R0cF=UzwG+-JAg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] another issue regarding to unstalling a pipeline domain
	explicitly
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

an interrupt happens and the pipeline stage is stalled. if the
pipeline stage must be unstalled explicitly by the handler, any where
i use a function to un-stall the domain inside an interrupt handler,
if another interrupt comes before the first handler is finished, it
will be caught and its handler will execute. So it will create a
nested interrupt and this can continue many times.
Is that what happens for Xenomai?
or the scheduler unstalls the pipeline domain? or i should write a
real time task to unstall the pipeline stage?


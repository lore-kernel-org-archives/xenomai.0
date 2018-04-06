MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 6 Apr 2018 09:51:37 -0700
Message-ID: <CA+K1mPGTJBd5OmUUhCcLVJMaHPhrwDgO34xtP6gG6qCvvw2BOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Context switch to secondary mode in xenomai tasks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all--

Our real time application has a main rt_task which runs concurrently with
several other rt_tasks (spawned using rt_task_create) and we are concerned
about a context switch in one of the tasks. The problematic task uses
libxml2 to parse an xml document sent over ethernet which seems to cause a
switch to secondary mode. Would this also switch the other tasks we are
running to secondary mode, or is it isolated?

We are running Xenomai 2.6.2 and Xenomai 2.6.5 in our application.

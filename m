MIME-Version: 1.0
From: Michael Smith <2michael.smith@gmail.com>
Date: Fri, 27 Nov 2015 08:09:15 +0200
Message-ID: <CANWkrROw+Ja4byL=aHjb8NpGHbNT2ebC5NH=wTpPN75C76nz9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Module reference count for real-time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi.
I am in the process of writing a rtdm device driver that is accessing
another rtmd driver.
But I am having difficulty finding an rtdm alternative for something
like the try_module_get() &
module_put().
Where the 1st module effectively locks the 2nd module from unloading
(via the module's reference count) until the 1st module is finished
accessing it.

Is there workaround for this, or an Xenomai alternative?

Thanks
Michael


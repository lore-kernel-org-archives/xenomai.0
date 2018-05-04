Date: Fri, 4 May 2018 17:42:35 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2o5aOu?= <yanghaha@whu.edu.cn>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <516d1f0e.b5f5.1632a8824d9.Coremail.yanghaha@whu.edu.cn>
Subject: [Xenomai] The step of Xenomai and ipipe function call and comments
 of ipipe function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I want to understand the workings of Xenomai, and I want to know how Xenomai realizes real-time, that is, the steps of the ipipe and Xenomai kernel function calls when a task comes. You have provided documentation for the Xenomai kernel API, but I have not found a comment for each function in the ipipe-core-3.14.17.patch, just like the function of __ipipe_do_IRQ(). Can you provide me with documentation of these functions? Or can you tell me how to know the kernel function call step?


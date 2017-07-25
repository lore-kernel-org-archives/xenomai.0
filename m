References: <DEB5F512-B818-454D-A423-7CB391071BBD@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8c41cf29-85da-e088-0e8a-9d0209cc2298@xenomai.org>
Date: Tue, 25 Jul 2017 16:27:08 +0200
MIME-Version: 1.0
In-Reply-To: <DEB5F512-B818-454D-A423-7CB391071BBD@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_create fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mathew.benson@gmail.com, xenomai@xenomai.org

On 07/25/2017 02:48 PM, mathew.benson@gmail.com wrote:
> I ported Xenomai 3.0.5 to Petalinux 2017.1.  The supported tests run fine, but my code is failing.  rt_task_create always fails with errno set to 17 (EEXIST).


Do you mean errno as the variable, or the function's return value?

-- 
Philippe.


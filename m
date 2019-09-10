Subject: Re: [xenomai-images][PATCH 1/9] ci: Add LAVA jobs for targets
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
 <20190905154425.10007-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c04ece77-0937-a01f-a1c2-c9dd73f84c62@siemens.com>
Date: Tue, 10 Sep 2019 11:56:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190905154425.10007-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 05.09.19 17:44, Q. Gylstorff via Xenomai wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Set up a LAVA Lab and add jobs for each target. These job descriptions
> deploy the build image to the target and run the LAVA basic smoketest
> suite for each target. Add lsb-release for smoke-test
> 

If someone wants to reuse CI but does not have a LAVA instance: Could we easily 
make the deployment and test step depend on, say, the LAVA environment variables 
being non-empty?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


References: <b18a880f-9765-86e1-5274-ba8bfb0cc832@xenomai.org>
 <aa1018f6-a352-5814-7bf4-0a309d84a88a@ma-info.de>
 <20180117112452.1bb130c9@laptop.fritz.box>
 <98376b05-0ed2-3171-7d9d-a77d42782d9f@xenomai.org>
 <20180117173800.4bca11b9@laptop.fritz.box>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ec3e2fe9-6a2a-e195-ca0c-cdf58acd7c99@xenomai.org>
Date: Wed, 17 Jan 2018 18:30:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180117173800.4bca11b9@laptop.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel panic xnclock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ruggero <rrossi@atb-biomag.de>
Cc: "Gaus Bernhard, Dr. Mergenthaler GmbH & Co. KG" <bernhard.gaus@ma-info.de>, xenomai@xenomai.org

On 01/17/2018 05:38 PM, ruggero wrote:
> Hi Pilippe,
> a small addition: the driver compile when included directly in the
> kernel. Normally we would like to have it as a module.
> 

diff --git a/arch/arm/kernel/ipipe.c b/arch/arm/kernel/ipipe.c
index 771bb5eff7fe..e0624d3f1ee2 100644
--- a/arch/arm/kernel/ipipe.c
+++ b/arch/arm/kernel/ipipe.c
@@ -557,4 +557,6 @@ EXPORT_SYMBOL_GPL(check_and_switch_context);
 EXPORT_SYMBOL_GPL(__cpu_logical_map);
 #endif /* CONFIG_IPIPE */
 
+EXPORT_SYMBOL_GPL(__ipipe_smp_key);
+
 EXPORT_SYMBOL_GPL(cpu_architecture);

-- 
Philippe.


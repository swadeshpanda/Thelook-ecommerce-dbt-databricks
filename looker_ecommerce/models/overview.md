{% docs __overview__ %}
# TheLook E-Commerce Analytics: dbt + Databricks

Tested, documented dbt models that turn raw TheLook e-commerce data into revenue,
product and customer insights.

**Layers**
- **staging:** one cleaned view per raw table (renames, type casts, PII removed)
- **intermediate:** reusable joins (order items with real unit cost)
- **marts:** facts, dimensions and business marts used by the dashboard

Use the lineage graph (bottom-right icon) to explore how models depend on each other.
{% enddocs %}